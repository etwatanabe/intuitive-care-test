<template>
  <div class="home-view">
    <h1>Busca de Operadoras</h1>
    <SearchForm :onSearch="fetchResults" />
    <SearchResults :results="results" />
  </div>
</template>

<script>
import SearchForm from "../components/SearchForm.vue";
import SearchResults from "../components/SearchResults.vue";
import api from "../services/apiService";

export default {
  components: { SearchForm, SearchResults },
  data() {
    return {
      results: [],
    };
  },
  methods: {
    async fetchResults(query) {
      try {
        const response = await api.get(`/search?query=${query}`);
        if (typeof response.data === "string") {
          this.results = JSON.parse(response.data);
        } else {
          this.results = response.data;
        }
      } catch (error) {
        console.error("Erro ao buscar os dados:", error);
        alert("Erro ao buscar os dados. Verifique o console para mais detalhes.");
        this.results = [];
      }
    },
  },
};
</script>

<style scoped>
.home-view {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  text-align: center;
}
</style>