FROM runpod/worker-comfyui:5.8.5-base
RUN python3 -c "c=open('/comfyui/extra_model_paths.yaml').read(); c=c.rstrip()+'\n  style_models: models/style_models/\n' if 'style_models' not in c else c; open('/comfyui/extra_model_paths.yaml','w').write(c); print(open('/comfyui/extra_model_paths.yaml').read())"
