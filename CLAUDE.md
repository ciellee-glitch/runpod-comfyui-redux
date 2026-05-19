# runpod-comfyui-redux

RunPod Serverless ComfyUI Docker 镜像构建项目。

## 仓库结构

- `Dockerfile` — 主镜像（FLUX + Z-Image，基于 runpod/worker-comfyui）
- `Dockerfile.scene-outfit` — 场景换装镜像（PuLID + ControlNet Union）
- `Dockerfile.kontext` — Kontext 指令编辑镜像
- `Dockerfile.supir` — SUPIR 超分镜像
- `save_jpeg/` — 自定义 SaveJpeg ComfyUI 节点

## 禁止 CPU 运行大模型

**所有 ONNX / PyTorch 模型必须跑 GPU，禁止 CPU fallback。**

- 每次新增自定义节点或依赖包，必须验证 ONNX Runtime 有 GPU provider 可用
- 判断标准：日志中不得出现以下任何一条：
  - `Available providers: '...CPUExecutionProvider'`（无 CUDA provider）
  - `switch to OpenCV with CPU device`
  - `WARNING: You need pytorch with cu130 or higher`
- 若出现上述警告，立即在对应 Dockerfile 加 `onnxruntime-gpu` 或对应 CUDA 依赖，不得忽略

**根因**：InsightFace（PuLID 人脸检测）、DWPose、OpenPose 等依赖 ONNX Runtime 的模型，若无 GPU provider 自动降级 CPU，推理时间从秒级变为十几分钟，导致 RunPod job 超时。

## 模型预烘焙规范

cold start 时下载大文件会导致 RunPod 执行超时，所有 Dockerfile 中凡新增自定义节点，必须同步预烘焙其所需模型：

- ControlNet 预处理器模型：用 `custom_hf_download(repo_id, filename)`
- HuggingFace 标准模型（如 EVA-CLIP）：用 `hf_hub_download(repo_id=..., filename=...)`
- 预烘焙 RUN 步骤放在 pip install 之后、COPY 之前

## Docker 镜像

- Docker Hub：`ciellee78/worker-comfyui-redux`
- 场景换装：`ciellee78/worker-comfyui-scene-outfit:v3`
- GitHub Actions 触发：push 到 main 分支

## RunPod Endpoint

| 用途 | Endpoint ID | 镜像 |
|------|-------------|------|
| FLUX + Z-Image | `ia93wb3p0oh9kr` | `worker-comfyui-redux:v7` |
| 场景换装 | `zeg37uzfpirfvs` | `worker-comfyui-scene-outfit:v3` |
| SUPIR 超分 | `8daqzktvsfe2aq` | `worker-comfyui-supir:v1` |
