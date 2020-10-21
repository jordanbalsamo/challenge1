FROM python:3.6.1-alpine
ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT
WORKDIR /app
ADD /src /app
RUN pip install -r requirements.txt
CMD ["python","server.py"]