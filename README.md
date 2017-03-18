# Journalbeat

## Run as a systemd Unit

```
- name: journalbeat.service
  command: start
  content: |
    [Unit]
    Description=ELK Logstash Beat for Journald
    After=docker.service
    Requires=docker.service
    [Service]
    TimeoutStartSec=0
    Restart=always
    ExecStartPre=-/usr/bin/mkdir -p /var/log/journalbeat
    ExecStartPre=-/usr/bin/docker stop %n
    ExecStartPre=-/usr/bin/docker rm %n
    ExecStart=/usr/bin/docker run --rm --name %n \
      -h %H \
      --log-driver=json-file \
      -v /etc/journalbeat.yml:/etc/journalbeat.yml \
      -v ${elk_logstash_forwarder_crt_dest}:/etc/logstash-forwarder.crt \
      -v /var/log/journalbeat:/var/log/journalbeat \
      -v /var/log/journal:/var/log/journal \
      -v /etc/machine-id:/etc/machine-id \
      bloo/journalbeat:${elk_journalbeat_version}
    [Install]
    WantedBy=multi-user.target
```

.. where `${elk_journalbeat_version}` and `${elk_logstash_forwarder_crt_dest}`
are defined externally (by terraform template or similar), and
`/etc/journalbeat.yml` exists on the host.
