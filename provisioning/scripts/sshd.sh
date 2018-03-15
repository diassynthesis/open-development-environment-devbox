#!/bin/sh -eux

SSHD_CONFIG="/etc/ssh/sshd_config"

# ensure that there is a trailing newline before attempting to concatenate
echo "==> Ensure that there is a trailing newline before attempting to concatenate in $SSHD_CONFIG"
# shellcheck disable=SC1003
sed -i -e '$a\' "$SSHD_CONFIG"

echo "==> Setup $SSHD_CONFIG DNS"
USEDNS="UseDNS no"
if grep -q -E "^[[:space:]]*UseDNS" "$SSHD_CONFIG"; then
    sed -i "s/^\\s*UseDNS.*/${USEDNS}/" "$SSHD_CONFIG"
else
    echo "$USEDNS" >>"$SSHD_CONFIG"
fi

echo "==> Setup $SSHD_CONFIG GSSAPIAuthentication"
GSSAPI="GSSAPIAuthentication no"
if grep -q -E "^[[:space:]]*GSSAPIAuthentication" "$SSHD_CONFIG"; then
    sed -i "s/^\\s*GSSAPIAuthentication.*/${GSSAPI}/" "$SSHD_CONFIG"
else
    echo "$GSSAPI" >>"$SSHD_CONFIG"
fi
