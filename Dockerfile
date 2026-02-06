FROM runpod/worker-comfyui:5.5.1-base
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /
RUN rm -rf /comfyui
RUN git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git /comfyui
WORKDIR /comfyui
RUN pip install -r requirements.txt --no-cache-dir

RUN rm -rf /comfyui/models
RUN mkdir -p /comfyui/models

COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

WORKDIR /comfyui/custom_nodes
RUN git clone --depth 1 https://github.com/WASasquatch/was-node-suite-comfyui.git
WORKDIR /comfyui/custom_nodes/was-node-suite-comfyui
RUN pip install -r requirements.txt --no-cache-dir
