FROM runpod/worker-comfyui:5.5.1-base

# Set environment variables
ENV COMFYUI_PATH=/comfyui

# Download models
WORKDIR ${COMFYUI_PATH}/models

# Download text encoder
RUN wget -q --show-progress \
    https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors \
    -O text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors

# Download LoRA
RUN wget -q --show-progress \
    https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-Lightning-4steps-V1.0-bf16.safetensors \
    -O loras/Qwen-Image-Edit-Lightning-4steps-V1.0-bf16.safetensors

# Download diffusion model
RUN wget -q --show-progress \
    https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_fp8_e4m3fn.safetensors \
    -O diffusion_models/qwen_image_edit_fp8_e4m3fn.safetensors

# Download VAE
RUN wget -q --show-progress \
    https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors \
    -O vae/qwen_image_vae.safetensors

# Download snorkel_lora
RUN wget -q --show-progress \
    https://huggingface.co/gugocco/snorkel_lora/resolve/main/snorkel_lora_v2.safetensors \
    -O loras/snorkel_lora.safetensors
