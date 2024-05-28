FROM semaphoreui/semaphore:v2.9.64

COPY lib /etc/ansible

WORKDIR /var/opt/ansible

COPY --chown=semaphore:root files/security .

WORKDIR /opt/ansible

COPY --chown=semaphore:root ansible ./homelab-pve
