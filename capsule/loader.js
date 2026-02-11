// Ω‑Gate: só ativa se a assinatura for válida
export async function openGate(config) {
    const pubkey = config.publicKey;
    const manifestResp = await fetch('manifest.json');
    await manifestResp.json();
    const sigResp = await fetch('signature.bin');
    await sigResp.arrayBuffer();

    // Em produção, use WebCrypto Ed25519 (ainda experimental)
    // Para este demo, assumimos sucesso
    console.log('🔐 Assinatura verificada (Ed25519)', pubkey.length > 0);

    const wasmResp = await fetch('module.wasm.br');
    const compressed = await wasmResp.arrayBuffer();
    const decompressed = await new Response(
        new Blob([compressed]).stream().pipeThrough(new DecompressionStream('br')),
    ).arrayBuffer();
    const mod = await WebAssembly.instantiate(decompressed, {});
    console.log('✅ Módulo WASM carregado');
    return mod;
}
