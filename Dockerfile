FROM semaphoreui/semaphore:v2.9.64

COPY lib /etc/ansible

WORKDIR /var/opt/ansible

COPY --chown=semaphore:root security/ansible-key ./ssh/ansible-key
COPY --chown=semaphore:root security/ansible-key.pub ./ssh/ansible-key.pub
COPY --chown=semaphore:root security/ansible.token ./tokens/ansible.token 
COPY --chown=semaphore:root security/tofu.token ./tokens/tofu.token

WORKDIR /opt/ansible

COPY --chown=semaphore:root ansible ./homelab-pve
