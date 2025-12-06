# Use a Jupyter base image that works well with Binder
FROM jupyter/base-notebook:latest

# Become root for system-level installs
USER root

# 1) Install Google Chrome from official .deb and Tor
RUN apt-get update -y && \
    apt-get install -y wget gnupg ca-certificates tor && \
    wget -q -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y /tmp/google-chrome.deb && \
    rm /tmp/google-chrome.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Back to the default notebook user
USER ${NB_UID}

# 2) Install Python packages
RUN pip install --no-cache-dir \
    selenium \
    webdriver-manager \
    stem \
    "requests[socks]"
