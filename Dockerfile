FROM runpod/worker-comfyui:5.8.5-base
RUN rm -rf /comfyui/models/style_models && \
    ln -s /runpod-volume/models/style_models /comfyui/models/style_models
