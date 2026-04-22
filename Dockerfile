FROM runpod/worker-comfyui:5.8.5-base
RUN python3 -c "
c = open('/comfyui/extra_model_paths.yaml').read()
print('BEFORE:', c)
if 'style_models' not in c:
    c = c.rstrip() + '\n  style_models: models/style_models/\n'
open('/comfyui/extra_model_paths.yaml', 'w').write(c)
print('AFTER:', open('/comfyui/extra_model_paths.yaml').read())
"
