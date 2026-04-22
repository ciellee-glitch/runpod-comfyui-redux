FROM runpod/worker-comfyui:5.8.5-base
RUN cat /start.sh 2>/dev/null || echo "NO /start.sh"
RUN grep -rn "unet: models\|extra_model_paths\|style_models" /comfyui/ /handler.py /start.sh 2>/dev/null | head -40 || true
RUN cat /comfyui/extra_model_paths.yaml 2>/dev/null || echo "NO YAML"
