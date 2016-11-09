FROM aegir/hostmaster

# You may override
ENV AEGIR_CLIENT_NAME admin
ENV AEGIR_CLIENT_EMAIL aegir@aegir.docker

# Change this for released versions
ENV AEGIR_MAKEFILE https://raw.githubusercontent.com/opendevshop/devshop/1.x/build-devmaster.make
ENV AEGIR_PROFILE devmaster

# Must be fixed across versions so we can upgrade containers.
ENV AEGIR_HOSTMASTER_ROOT /var/aegir/devmaster

USER root
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Install devshop CLI
RUN \
  git clone https://github.com/opendevshop/devshop /usr/share/devshop && \
  cd /usr/share/devshop && \
  composer install && \
  ln -s /usr/share/devshop/bin/devshop /usr/local/bin/devshop

USER aegir
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["drush @hostmaster hosting-queued"]