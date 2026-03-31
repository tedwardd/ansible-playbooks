require ["fileinto", "mailbox"];

# ── FreeBSD ───────────────────────────────────────────────────────────────────
# More specific subfolders must come before the parent catch-all.

if header :contains "List-Id" "freebsd-current" {
    fileinto :create "INBOX.Mailing Lists.FreeBSD.CURRENT";
    stop;
}

if header :contains "List-Id" "freebsd-usb" {
    fileinto :create "INBOX.Mailing Lists.FreeBSD.USB";
    stop;
}

if anyof (
    header :contains "List-Id" "freebsd-announce",
    header :contains "Subject" "[FreeBSD-Announce]"
) {
    fileinto :create "INBOX.Mailing Lists.FreeBSD.Announce";
    stop;
}

if anyof (
    header :contains "From" "security-advisories@freebsd.org",
    header :contains "Subject" "[FreeBSD-Security]"
) {
    fileinto :create "INBOX.Mailing Lists.FreeBSD.Security";
    stop;
}

if anyof (
    header :contains "From" "errata-notices@freebsd.org",
    header :contains "Subject" "[FreeBSD-Errata]"
) {
    fileinto :create "INBOX.Mailing Lists.FreeBSD.Errata";
    stop;
}

# Catch-all for remaining FreeBSD list mail
if anyof (
    header :contains "List-Id" "freebsd",
    header :contains "From" "mailman-owner@freebsd.org",
    header :contains "Subject" "[FreeBSD]"
) {
    fileinto :create "INBOX.Mailing Lists.FreeBSD";
    stop;
}

# ── Fedora ────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "devel.lists.fedoraproject.org",
    header :contains "Subject" "[Fedora-devel]"
) {
    fileinto :create "INBOX.Mailing Lists.Fedora.Devel";
    stop;
}

if anyof (
    header :contains "List-Id" "server.lists.fedoraproject.org",
    header :contains "Subject" "[Fedora-server]"
) {
    fileinto :create "INBOX.Mailing Lists.Fedora.Server";
    stop;
}

# ── OpenBSD ───────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "announce.openbsd.org",
    header :contains "Subject" "[OpenBSD-Announce]"
) {
    fileinto :create "INBOX.Mailing Lists.OpenBSD.Announce";
    stop;
}

if anyof (
    header :contains "List-Id" "misc.openbsd.org",
    header :contains "Subject" "[OpenBSD-Misc]"
) {
    fileinto :create "INBOX.Mailing Lists.OpenBSD.Misc";
    stop;
}

# ── Slackware ─────────────────────────────────────────────────────────────────

if anyof (
    header :contains "From" "slackware-security@slackware.com",
    header :contains "Sender" "owner-slackware-security@slackware.com",
    header :contains "Subject" "[slackware-security]"
) {
    fileinto :create "INBOX.Mailing Lists.Slackware.Security";
    stop;
}

# Catch-all for remaining Slackware mail
if anyof (
    header :contains "From" "@slackware.com",
    header :contains "Sender" "owner-slackware",
    header :contains "Subject" "[slackware-"
) {
    fileinto :create "INBOX.Mailing Lists.Slackware";
    stop;
}

# ── TOR ───────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "tor-announce.lists.torproject.org",
    header :contains "Subject" "[Tor-announce]"
) {
    fileinto :create "INBOX.Mailing Lists.TOR.Announce";
    stop;
}

# Catch-all for remaining TOR list mail
if anyof (
    header :contains "List-Id" "lists.torproject.org",
    header :contains "Subject" "[Tor-"
) {
    fileinto :create "INBOX.Mailing Lists.TOR";
    stop;
}

# ── Docker ────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "docker-dev.googlegroups.com",
    header :contains "From" "docker-dev@googlegroups.com",
    header :contains "Subject" "[docker-dev]"
) {
    fileinto :create "INBOX.Mailing Lists.Docker.Dev";
    stop;
}

# ── CVEs / Security Advisories ────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "oss-security.lists.openwall.com",
    header :contains "From" "oss-security@lists.openwall.com"
) {
    fileinto :create "INBOX.Mailing Lists.CVEs";
    stop;
}

# ── VIM ───────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "Sender" "vim_use@googlegroups.com",
    header :contains "From" "vim@vim.org"
) {
    fileinto :create "INBOX.Mailing Lists.VIM";
    stop;
}

# ── DC404 ─────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "kaos.to",
    header :contains "From" "@lists.kaos.to"
) {
    fileinto :create "INBOX.Mailing Lists.DC404";
    stop;
}

# ── ALE ───────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "ale.org",
    header :contains "From" "@ale.org",
    header :contains "Subject" "[ale]"
) {
    fileinto :create "INBOX.Mailing Lists.ALE";
    stop;
}

# ── Archlinux ─────────────────────────────────────────────────────────────────

if header :contains "List-Id" "lists.archlinux.org" {
    fileinto :create "INBOX.Mailing Lists.Archlinux";
    stop;
}

# ── Cypherpunks ───────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "cypherpunks.lists.cpunks.org",
    header :contains "From" "@cpunks.org"
) {
    fileinto :create "INBOX.Mailing Lists.Cpunks";
    stop;
}

# ── Cryptography (Randombit) ──────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "cryptography.randombit.net",
    header :contains "From" "cryptography@randombit.net"
) {
    fileinto :create "INBOX.Mailing Lists.Cryptography(Randombit)";
    stop;
}

# ── Radio ─────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "List-Id" "vhfcontesting.contesting.com",
    header :contains "Subject" "[VHFcontesting]"
) {
    fileinto :create "INBOX.Radio.VHF Contesting";
    stop;
}

if anyof (
    header :contains "List-Id" "QRPLabs.groups.io",
    header :contains "Subject" "[QRPLabs]"
) {
    fileinto :create "INBOX.Radio.QRPLabs";
    stop;
}

if anyof (
    header :contains "List-Id" "wsjtx.groups.io",
    header :contains "Subject" "[WSJTX]"
) {
    fileinto :create "INBOX.Radio.WSJTX";
    stop;
}

if anyof (
    header :contains "List-Id" "ninotnc.groups.io",
    header :contains "Subject" "[NinoTNC]"
) {
    fileinto :create "INBOX.Radio.NinoTNC";
    stop;
}

if anyof (
    header :contains "List-Id" "fourlanders.contesting.com",
    header :contains "Subject" "[Fourlanders]"
) {
    fileinto :create "INBOX.Radio.FourLanders";
    stop;
}

# ── CryptoGram ────────────────────────────────────────────────────────────────

if anyof (
    header :contains "From" "schneier@schneier.com",
    header :contains "Subject" "CRYPTO-GRAM"
) {
    fileinto :create "INBOX.cryptogram";
    stop;
}

# ── FSF ───────────────────────────────────────────────────────────────────────

if header :contains "From" "info@fsf.org" {
    fileinto :create "INBOX.fsf";
    stop;
}

# ── GitHub ────────────────────────────────────────────────────────────────────

if anyof (
    header :contains "From" "noreply@github.com",
    header :contains "Subject" "[GitHub]"
) {
    fileinto :create "INBOX.github";
    stop;
}
