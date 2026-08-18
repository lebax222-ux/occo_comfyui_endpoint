# Qwen-Image-Edit-2511 serverless worker with models baked into the image.
# Network volumes are NOT required.
#
# Build (must be linux/amd64 for RunPod):
#   docker build --platform linux/amd64 -t YOUR_USER/qwen-image-edit-2511:latest .
#
# Image is large (~30GB+). Prefer building locally / Docker Hub if RunPod
# GitHub builds hit the 30-minute docker-build timeout.
FROM runpod/worker-comfyui:5.8.6-base

# Diffusion — FP8 mixed (~20.5 GB). Use a 24GB+ GPU (e.g. RTX 4090).
# For BF16 instead, swap the URL/filename to qwen_image_edit_2511_bf16.safetensors (~40 GB, needs 40GB+ VRAM).
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2511_fp8mixed.safetensors \
    --relative-path models/diffusion_models \
    --filename qwen_image_edit_2511_fp8mixed.safetensors

# Text encoder
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/HunyuanVideo_1.5_repackaged/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors \
    --relative-path models/text_encoders \
    --filename qwen_2.5_vl_7b_fp8_scaled.safetensors

# VAE
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors \
    --relative-path models/vae \
    --filename qwen_image_vae.safetensors

# Lightning LoRA (4-step)
RUN comfy model download \
    --url https://huggingface.co/lightx2v/Qwen-Image-Edit-2511-Lightning/resolve/main/Qwen-Image-Edit-2511-Lightning-4steps-V1.0-bf16.safetensors \
    --relative-path models/loras \
    --filename Qwen-Image-Edit-2511-Lightning-4steps-V1.0-bf16.safetensors

# Load Image From URL / Local Path
RUN git clone --depth 1 \
    https://github.com/tsogzark/ComfyUI-load-image-from-url.git \
    /comfyui/custom_nodes/ComfyUI-load-image-from-url


