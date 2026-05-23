#!/usr/bin/env node

const net = require("net");
const os = require("os");
const path = require("path");
const crypto = require("crypto");

function usage() {
  console.error(`Usage: moshi-attention.js [options]

Options:
  --title <text>       Push title. Default: "Codex needs attention"
  --subtitle <text>    Push subtitle. Default: "Tap to respond"
  --message <text>     Push body message.
  --timeout <seconds>  Seconds to wait for approve/deny. Default: 30
  --cwd <path>         Working directory to report. Default: current directory
  --session-id <id>    Session ID. Default: CODEX_SESSION_ID or random UUID
  --socket <path>      Moshi socket path. Default: ~/Library/Application Support/Moshi/moshi-hook.sock
  --help              Show this help.
`);
}

function parseArgs(argv) {
  const opts = {
    title: "Codex needs attention",
    subtitle: "Tap to respond",
    message: "",
    timeout: 30,
    cwd: process.cwd(),
    sessionId: process.env.CODEX_SESSION_ID || crypto.randomUUID(),
    socket: path.join(os.homedir(), "Library", "Application Support", "Moshi", "moshi-hook.sock"),
  };

  for (let i = 0; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === "--help" || arg === "-h") {
      usage();
      process.exit(0);
    }
    const needsValue = ["--title", "--subtitle", "--message", "--timeout", "--cwd", "--session-id", "--socket"];
    if (!needsValue.includes(arg)) {
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
    switch (arg) {
      case "--title":
        opts.title = value;
        break;
      case "--subtitle":
        opts.subtitle = value;
        break;
      case "--message":
        opts.message = value;
        break;
      case "--timeout":
        opts.timeout = Number(value);
        if (!Number.isFinite(opts.timeout) || opts.timeout < 1) {
          console.error("--timeout must be a positive number of seconds");
          process.exit(2);
        }
        break;
      case "--cwd":
        opts.cwd = value;
        break;
      case "--session-id":
        opts.sessionId = value;
        break;
      case "--socket":
        opts.socket = value;
        break;
    }
  }

  if (!opts.message) {
    opts.message = `Codex needs your attention at ${new Date().toISOString()}`;
  }

  return opts;
}

const opts = parseArgs(process.argv.slice(2));
const now = new Date();
const envelope = {
  type: "approval.request",
  source: "codex",
  sessionId: opts.sessionId,
  actionId: `attention-${Date.now().toString(16)}`,
  eventName: "PermissionRequest",
  phase: "waitingForApproval",
  category: "approval_required",
  cwd: opts.cwd,
  projectName: path.basename(opts.cwd) || "task",
  toolName: "Codex",
  title: opts.title,
  subtitle: opts.subtitle,
  message: opts.message,
  expiresAt: new Date(Date.now() + Math.max(opts.timeout, 1) * 1000).toISOString(),
  requestedAt: now.toISOString(),
};

const sock = net.createConnection({ path: opts.socket });
let data = "";
let settled = false;

function finish(code, text) {
  if (settled) return;
  settled = true;
  try {
    sock.destroy();
  } catch {}
  if (text) console.log(text);
  process.exit(code);
}

sock.on("connect", () => {
  sock.write(`${JSON.stringify(envelope)}\n`);
});

sock.on("data", (chunk) => {
  data += chunk.toString("utf8");
  if (data.includes("\n")) {
    finish(0, data.trim());
  }
});

sock.on("error", (err) => {
  finish(1, err.message);
});

setTimeout(() => {
  finish(0, "sent Moshi attention push; no response before timeout");
}, opts.timeout * 1000).unref();
