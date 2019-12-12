ARG base
FROM $base

# Install Build tools
RUN apk --no-cache add --virtual=for-build \
    git ca-certificates openssl-dev readline-dev \
    bzip2-dev zlib-dev sqlite-dev ncurses-dev \
    libffi-dev linux-headers build-base

# Install Python3.7
RUN apk --no-cache add --virtual=for-build curl git && \
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile && \
    echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile && \
    source ~/.bash_profile && \
    pyenv install 3.7.3 && \
    pyenv global 3.7.3

# Clearn up
RUN apk del --purge for-build
