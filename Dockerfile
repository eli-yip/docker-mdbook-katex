FROM alpine:3.19 AS Builder

ENV MDBOOK_VERSION 0.4.36
ENV MDBOOK_KATEX_VERSION 0.5.9

WORKDIR /app

RUN apk add curl && \
  curl -L https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-musl.tar.gz -o mdbook.tar.gz && \
  tar -xzvf mdbook.tar.gz && \
  curl -L https://github.com/lzanini/mdbook-katex/releases/download/v${MDBOOK_KATEX_VERSION}/mdbook-katex-v${MDBOOK_KATEX_VERSION}-x86_64-unknown-linux-musl.tar.gz -o mdbook-katex.tar.gz && \
  tar -xzvf mdbook-katex.tar.gz

FROM alpine:3.19

COPY --from=Builder /app/mdbook /usr/bin/mdbook
COPY --from=Builder /app/mdbook-katex /usr/bin/mdbook-katex

WORKDIR /book
ENTRYPOINT ["/usr/bin/mdbook"]
CMD ["build"]
