#!/usr/bin/env node

const { spawnSync } = require("node:child_process");
const fs = require("node:fs");
const https = require("node:https");
const os = require("node:os");

const WEBHOOK_URL = "https://api.getmoshi.app/api/webhook";

function usage() {
  console.error(`Usage: moshi-webhook.js [options]

Options:
  --title <text>     Push title. Default: "Codex task done"
  --message <text>   Push body message. Default: "The requested work is ready to review."
  --no-unified       Disable unified notification mode.
  --help             Show this help.
`);
}

function parseArgs(argv) {
  const opts = {
    title: "Codex task done",
    message: "The requested work is ready to review.",
    unified: true,
  };

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === "--help" || arg === "-h") {
      usage();
      process.exit(0);
    }
    if (arg === "--no-unified") {
      opts.unified = false;
      continue;
    }
    if (arg !== "--title" && arg !== "--message") {
      console.error(`Unknown option: ${arg}`);
      usage();
      process.exit(2);
    }
    const value = argv[i + 1];
    if (!value) {
      console.error(`Missing value for ${arg}`);
      usage();
      process.exit(2);
    }
    i += 1;
    if (arg === "--title") opts.title = value;
    if (arg === "--message") opts.message = value;
  }

  return opts;
}

function readWebhookTokenFromPrivateFile() {
  const homeDir = process.env.HOME || os.homedir();
  if (!homeDir) return "";

  const privatePath = `${homeDir}/.private`;
  if (!fs.existsSync(privatePath)) return "";

  const result = spawnSync(
    "zsh",
    ["-fc", 'source "$HOME/.private" >/dev/null 2>&1; print -r -- ${MOSHI_WEBHOOK_TOKEN-}'],
    {
      encoding: "utf8",
      env: { ...process.env, HOME: homeDir },
      maxBuffer: 1024 * 1024,
    },
  );

  if (result.status !== 0) return "";
  return result.stdout.trim();
}

function readWebhookToken() {
  const envToken = process.env.MOSHI_WEBHOOK_TOKEN?.trim();
  if (envToken) return envToken;

  const privateToken = readWebhookTokenFromPrivateFile();
  if (privateToken) return privateToken;

  console.error("Missing Moshi webhook token.");
  console.error("Set MOSHI_WEBHOOK_TOKEN in ~/.private.");
  process.exit(2);
}

function sendWebhook(opts) {
  const body = JSON.stringify({
    token: readWebhookToken(),
    title: opts.title,
    message: opts.message,
    unified: opts.unified,
  });

  const request = https.request(
    WEBHOOK_URL,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Content-Length": Buffer.byteLength(body),
      },
    },
    (response) => {
      let response_body = "";
      response.on("data", (chunk) => {
        response_body += chunk.toString("utf8");
      });
      response.on("end", () => {
        let payload = null;
        try {
          payload = JSON.parse(response_body);
        } catch {}

        if (response.statusCode !== 200 || !payload?.success || !payload?.pushSent) {
          console.error(`Moshi webhook failed with HTTP ${response.statusCode ?? "unknown"}`);
          if (response_body) console.error(response_body);
          process.exit(1);
        }

        console.log("Moshi webhook delivered");
      });
    },
  );

  request.on("error", (error) => {
    console.error(`Moshi webhook error: ${error.message}`);
    process.exit(1);
  });

  request.end(body);
}

sendWebhook(parseArgs(process.argv.slice(2)));
