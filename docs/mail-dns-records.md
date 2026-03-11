# Mail Server DNS Records (xy0.org)

These records must be manually set in DNS whenever the mail server is provisioned to a new host.

## MX Record
| Type | Name    | Value          | Priority |
|------|---------|----------------|----------|
| MX   | xy0.org | mail.xy0.org   | 10       |

## A Record
| Type | Name         | Value              |
|------|--------------|-------------------|
| A    | mail.xy0.org | \<server public IP\> |

## SPF Record
| Type | Name    | Value                         |
|------|---------|-------------------------------|
| TXT  | xy0.org | v=spf1 mx a:mail.xy0.org ~all |

## DKIM Record

After provisioning, retrieve the new public key from the server:

```bash
ssh elw@<new-server> sudo cat /etc/opendkim/keys/xy0.org/default.txt
```

The Ansible opendkim role also prints this key as a debug message during the play run.

| Type | Name                       | Value                      |
|------|----------------------------|----------------------------|
| TXT  | default._domainkey.xy0.org | \<contents of default.txt\> |

> **Note:** A new DKIM keypair is generated on each fresh server. DNS must be updated with the new public key before outbound mail will pass DKIM validation.

## DMARC Record
| Type | Name           | Value                                       |
|------|----------------|---------------------------------------------|
| TXT  | _dmarc.xy0.org | v=DMARC1; p=none; rua=mailto:admin@xy0.org  |
