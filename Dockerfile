ARG base
FROM $base

# Install Build tools
RUN apt update && apt install -y \
        curl \
        git \
        zlib1g-dev \
        libssl-dev \
        libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.7.4
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile && \
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile && \
    source ~/.bash_profile && \
    pyenv install 3.7.4 && \
    pyenv global 3.7.4 && \
    sed -i '20asource ~/.bash_profile' /opt/entrypoint.sh
