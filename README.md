# Journalbeat

## Run with external configuration

```
docker run -it \
  --name journalbeat \
  -v $(pwd)/journalbeat.yml:/etc/journalbeat.yml \
  -v $(pwd)/logstash-forwarder.crt:/etc/logstash-forwarder.crt \
  -v /var/log/journalbeat:/var/log/journalbeat \
  -e LOGSTASH_HOST=${LOGSTASH_HOST} \
  bloo/journalbeat:local
```
