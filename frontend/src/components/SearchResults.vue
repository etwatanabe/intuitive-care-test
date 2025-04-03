<template>
  <div class="search-results">
    <table v-if="paginatedResults.length">
      <thead>
        <tr>
          <th>Registro ANS</th>
          <th>Razão Social</th>
          <th>Nome Fantasia</th>
          <th>CNPJ</th>
          <th>Modalidade</th>
          <th>Logradouro</th>
          <th>Número</th>
          <th>Complemento</th>
          <th>Bairro</th>
          <th>Cidade</th>
          <th>UF</th>
          <th>CEP</th>
          <th>Telefone</th>
          <th>Representante</th>
          <th>Cargo Representante</th>
          <th>Data Registro ANS</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(result, index) in paginatedResults" :key="index">
          <td>{{ result.Registro_ANS }}</td>
          <td>{{ result.Razao_Social }}</td>
          <td>{{ result.Nome_Fantasia }}</td>
          <td>{{ formatCNPJ(result.CNPJ) }}</td>
          <td>{{ result.Modalidade }}</td>
          <td>{{ result.Logradouro }}</td>
          <td>{{ result.Numero }}</td>
          <td>{{ result.Complemento }}</td>
          <td>{{ result.Bairro }}</td>
          <td>{{ result.Cidade }}</td>
          <td>{{ result.UF }}</td>
          <td>{{ result.CEP }}</td>
          <td>{{ formatPhone(result.Telefone, result.DDD) }}</td>
          <td>{{ result.Representante }}</td>
          <td>{{ result.Cargo_Representante }}</td>
          <td>{{ formatDate(result.Data_Registro_ANS) }}</td>
        </tr>
      </tbody>
    </table>

    <p v-else>Nenhum resultado encontrado.</p>

    <!-- Paginação -->
    <div class="pagination" v-if="totalPages > 1">
      <button
        :disabled="currentPage === 1"
        @click="changePage(currentPage - 1)"
      >
        Anterior
      </button>
      <span>Página {{ currentPage }} de {{ totalPages }}</span>
      <button
        :disabled="currentPage === totalPages"
        @click="changePage(currentPage + 1)"
      >
        Próxima
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: ["results"],
  data() {
    return {
      currentPage: 1,
      itemsPerPage: 20, // Número de registros por página
    };
  },
  computed: {
    totalPages() {
      return Math.ceil(this.results.length / this.itemsPerPage);
    },
    paginatedResults() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      const end = start + this.itemsPerPage;
      console.log("Resultados recebidos:", this.results.slice(start, end));
      return this.results.slice(start, end);
    },
  },
  methods: {
    changePage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page;
      }
    },
    formatCNPJ(cnpj) {
      if (!cnpj) return "N/A";
      return cnpj.toString().replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, "$1.$2.$3/$4-$5");
    },
    formatPhone(phone, ddd) {
      if (!phone || !ddd) return "N/A";
      const formattedPhone = phone.toString().replace(/^(\d{4,5})(\d{4})$/, "$1-$2");
      return `(${Math.floor(ddd)}) ${formattedPhone}`;
    },
    formatDate(date) {
      if (!date) return "N/A";
      const options = { year: "numeric", month: "2-digit", day: "2-digit" };
      return new Date(date).toLocaleDateString("pt-BR", options);
    },
  },
};
</script>

<style scoped>
.search-results {
  display: flex;
  flex-direction: column;
  align-items: center; /* Centraliza horizontalmente */
  justify-content: center; /* Centraliza verticalmente, se necessário */
}

table {
  width: 90%; /* Ajuste a largura da tabela */
  max-width: 1200px; /* Limita a largura máxima */
  border-collapse: collapse;
  margin-bottom: 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Adiciona sombra */
  border-radius: 8px; /* Bordas arredondadas */
  overflow: hidden; /* Garante que o conteúdo respeite as bordas arredondadas */
}

th, td {
  border: 1px solid #ddd;
  padding: 12px; /* Aumenta o espaçamento interno */
  text-align: left;
  font-size: 14px; /* Ajusta o tamanho da fonte */
}

th {
  background-color:rgb(123, 184, 248); /* Cor de fundo para o cabeçalho */
  color: #000; /* Cor do texto no cabeçalho */
  text-transform: uppercase; /* Deixa o texto em maiúsculas */
  font-weight: bold;
}

tr:nth-child(even) {
  background-color: #f9f9f9; /* Cor de fundo para linhas pares */
}

tr:hover {
  background-color: #f1f1f1; /* Cor de fundo ao passar o mouse */
}

.pagination {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 20px;
}

button {
  padding: 8px 16px;
  font-size: 14px;
  cursor: pointer;
  border: none;
  background-color: #007bff;
  color: white;
  border-radius: 4px;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #0056b3;
}

button:disabled {
  cursor: not-allowed;
  opacity: 0.5;
}
</style>