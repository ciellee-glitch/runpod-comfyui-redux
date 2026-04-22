FROM runpod/worker-comfyui:5.8.5-base
RUN echo "    style_models: models/style_models/" >> /extra_model_paths.yaml
