FROM cgr.dev/chainguard/python:latest-dev as builder

WORKDIR /app
RUN python -m venv venv
ENV PATH="/app/venv/bin":$PATH
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest
WORKDIR /app
COPY . .
COPY --from=builder /app/venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
EXPOSE 5000
ENTRYPOINT ["python","-m","flask","run","--host=0.0.0.0"]
