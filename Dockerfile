FROM python:3.11

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY ./ ./

RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN python intelligent_systems/manage.py migrate 

EXPOSE 8000

CMD ["python", "intelligent_systems/manage.py", "runserver", "0.0.0.0:8000"]
