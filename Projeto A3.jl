using LinearAlgebra

# Definir a matriz de transição P
P = [0.9 0.1;  # P(O → O), P(O → M)
     0.7 0.3]  # P(M → O), P(M → M)

# Encontrar a distribuição estacionária π (autovetor associado ao autovalor 1)
function stationary_distribution(P)
    # Encontra autovetores e autovalores
    eigvals, eigvecs = eigen(P')

    # Procura o autovalor ≈ 1 (devido a erros numéricos)
    idx = findfirst(x -> isapprox(x, 1.0, atol=1e-8), eigvals)
    
    # Pega o autovetor correspondente e normaliza
    π = eigvecs[:, idx]
    π = π / sum(π)
    
    return real.(π)  # Garante que não haja partes imaginárias (devido a erros numéricos)
end

# Calcula a distribuição estacionária
π = stationary_distribution(P)

# Frota total de caminhões
total_caminhoes = 100

# Caminhões operacionais e em manutenção no estado estacionário
caminhoes_operacionais = π[1] * total_caminhoes
caminhoes_manutencao = π[2] * total_caminhoes

# Exibe os resultados
println("Distribuição estacionária:")
println(" (Operacional) = ", round(π[1], digits=4), " → ", round(caminhoes_operacionais, digits=1), " caminhões")
println(" (Manutenção) = ", round(π[2], digits=4), " → ", round(caminhoes_manutencao, digits=1), " caminhões")