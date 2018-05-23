FROM ubuntu:16.04
MAINTAINER laudai

RUN apt-get update && \
    apt-get install vim tmux zsh git htop curl wget cron -y

# run cron at start container .
RUN service cron start

WORKDIR /root
# use oh-my-zsh to decorate zsh theme and can add plungins at ond days .
RUN git clone https://github.com/robbyrussell/oh-my-zsh && \
    mv oh-my-zsh .oh-my-zsh

RUN git clone https://github.com/laudai/dotfile.git && \
	cd dotfile && \
	git checkout tmux2.5

WORKDIR /root
RUN mv dotfile .dotfile
RUN touch .vimrc .zshrc .tmux.conf && \
    echo "source ~/.dotfile/laudai.vimrc" > .vimrc && \
    echo "source ~/.dotfile/laudai.zshrc" > .zshrc && \
    echo "source ~/.dotfile/laudai.tmux.conf" > .tmux.conf

ENTRYPOINT /usr/bin/zsh
ENV ZSH=~/.oh-my-zsh

CMD ["/usr/bin/zsh"]
