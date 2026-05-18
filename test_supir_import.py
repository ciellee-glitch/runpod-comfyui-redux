import sys
import traceback

sys.path.insert(0, '/comfyui')
sys.path.insert(0, '/comfyui/custom_nodes/ComfyUI-SUPIR')

try:
    import nodes as supir_nodes
    print("SUPIR import OK")
    print("NODE_CLASS_MAPPINGS:", list(supir_nodes.NODE_CLASS_MAPPINGS.keys()))
except Exception as e:
    traceback.print_exc()
    sys.exit(1)
