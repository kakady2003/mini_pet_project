FROM python:3.12-slim

COPY . .
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# Отключаем создание виртуального окружения внутри Poetry
# (в Docker оно не нужно)
RUN poetry config virtualenvs.create false

# Копируем pyproject.toml и poetry.lock
WORKDIR /app
COPY pyproject.toml poetry.lock* ./
RUN poetry install --no-root --only main

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]