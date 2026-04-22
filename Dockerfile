FROM runpod/worker-comfyui:5.8.5-base
COPY extra_model_paths.yaml /extra_model_paths.yaml
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml
