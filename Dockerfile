## Use the Official Python 3.10 Image
FROM python:3.10 

## Set the working directory to /code
WORKDIR /code

## Copy the current directory contents in the container at .code
COPY ./requirements.txt /code/requirements.txt

## Install the requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt 

# Set up a New User named "GenAI"
RUN useradd GenAI

# Switch to the "user" user
USER GenAI

# Set home to the user's homedirectory
ENV HOME=/home/GenAI \
    PATH=/home/GenAI/.local/bin:${PATH}

#  Set the working directory to the user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app setting the owner to 
COPY --chown=GenAI . $HOME/app

## Start the FASTAPI App on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port","7860"]