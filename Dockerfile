FROM alpine:3.21 AS builder

ENV MDBOOK_VERSION=0.4.44
ENV MDBOOK_KATEX_VERSION=0.9.2

WORKDIR /app

RUN apk add curl && \
  curl -L https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-musl.tar.gz -o mdbook.tar.gz && \
  tar -xzvf mdbook.tar.gz && \
  curl -L https://github.com/lzanini/mdbook-katex/releases/download/${MDBOOK_KATEX_VERSION}-binaries/mdbook-katex-v${MDBOOK_KATEX_VERSION}-x86_64-unknown-linux-musl.tar.gz -o mdbook-katex.tar.gz && \
  tar -xzvf mdbook-katex.tar.gz

FROM alpine:3.21

COPY --from=builder /app/mdbook /app/mdbook
COPY --from=builder /app/mdbook-katex /app/mdbook-katex

ENV PATH="/app:${PATH}"
WORKDIR /book
ENTRYPOINT ["/app/mdbook"]
CMD ["build"]
