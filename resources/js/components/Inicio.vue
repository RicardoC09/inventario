<template>
    <div class="container-body">
        <div class="contenedor-tablas">
            <div class="card">
                <b-card
                    border-variant="danger"
                    header="Danger"
                    header-border-variant="danger"
                    header-text-variant="danger"
                    align="center">
                    <b-card-text>
                        <div class="primer_multiselect">
                            <label class="typo__label">Seccion</label>
                            <multiselect v-model="value" :options="options" :custom-label="nameWithLang"
                                         placeholder="Select one"
                                         label="name" track-by="name"></multiselect>
                        </div>
                    </b-card-text>
                </b-card>
            </div>
        </div>
    </div>
</template>

<script>
    import Multiselect from 'vue-multiselect'

    export default {
        name: 'inicio',
        components: {
            Multiselect
        },
        data() {
            return {
                value: {name: 'Vue.js', language: 'JavaScript'},
                options: [
                    {name: 'Vue.js', language: 'JavaScript'},
                    {name: 'Rails', language: 'Ruby'},
                    {name: 'Sinatra', language: 'Ruby'},
                    {name: 'Laravel', language: 'PHP'},
                    {name: 'Phoenix', language: 'Elixir'}
                ]
            }
        },
        methods: {
            nameWithLang({name, language}) {
                return `${name} — [${language}]`
            }
        }
    }
</script>
<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
<style scoped>
    .primer_multiselect {
        width: 20%;
    }

    .segundo_multiselect {
        width: 20%;
        right: 60%;
    }

    .contenedor-buscar {
        position: relative;
        top: 11px;
    }
</style>
