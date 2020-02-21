ARG base
FROM $base

# Install Build tools
RUN apk --no-cache add --virtual=for-build \
    ca-certificates openssl-dev readline-dev \
    bzip2-dev zlib-dev sqlite-dev ncurses-dev \
    libffi-dev linux-headers build-base curl git

# Install Python3.7.4
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile && \
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile && \
    source ~/.bash_profile && \
    pyenv install 3.7.4 && \
    pyenv global 3.7.4 && \
    sed -i '20asource ~/.bash_profile' /opt/entrypoint.sh

# Clearn up
RUN apk del --purge for-build
