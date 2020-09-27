version: '3.7'

services:
  app:
    image: {{DOCKER_IMAGE}}
    env_file: .env
    network_mode: host
    restart: always
