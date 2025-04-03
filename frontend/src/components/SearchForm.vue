<template>
  <div class="search-form">
    <input
      v-model="query"
      placeholder="Digite o termo de busca"
      @keyup.enter="search"
    />
    <button @click="search" class="search-button">Buscar</button>
  </div>
</template>

<script>
export default {
  props: ["onSearch"],
  data() {
    return {
      query: "",
    };
  },
  methods: {
    search() {
      if (this.query.trim() === "") {
        alert("Por favor, insira um termo de busca.");
        return;
      }
      this.onSearch(this.query);
    },
  },
};
</script>

<style scoped>
.search-form {
  display: flex;
  gap: 10px;
  justify-content: center;
  margin-bottom: 20px;
}

input {
  flex: 1;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.search-button {
  padding: 10px 20px;
  font-size: 16px;
  font-weight: bold;
  color: white;
  background-color: #007bff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

.search-button:hover {
  background-color: #0056b3;
}

.search-button:active {
  transform: scale(0.98); /* Efeito de clique */
}

.search-button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}
</style>