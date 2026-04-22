FROM runpod/worker-comfyui:5.8.5-base
RUN echo "=== /start.sh ===" && cat /start.sh && \
    echo "=== patching ===" && \
    sed -i '/unet: models\/unet/a\  style_models: models\/style_models\/' /start.sh && \
    echo "=== after patch ===" && grep -A2 "unet: models" /start.sh
