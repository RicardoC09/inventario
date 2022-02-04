<template>
    <div>
        <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
            <!-- Card stats -->
            <div class="row"></div>
        </base-header>
        <div class="container-fluid mt--7">
            <div class="row">
                <div class="col">
                    <div class="card shadow">
                        <div class="card-header bg-transparent">
                            <h3 class="mb-0">Inventario</h3>
                        </div>
                        <div class="card-body"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import Multiselect from "vue-multiselect";
import VueBootstrap4Table from "vue-bootstrap4-table";
import swal from "sweetalert";
import axios from "axios";
export default {
    mounted() {
        this.listSeccion();
        this.listQuery();
    },
    name: "inventario",
    components: { Multiselect, swal, VueBootstrap4Table },

    data() {
        return {
            subSerie: "",
            comment: "",
            nameProceedings: "",
            openDate: "",
            fileNumber: "",
            seccions: "",
            subSeccion: "",
            serie: "",
            proceedings_modal: false,

            filter: [],
            options_subSerie: [],
            options_seccions: [],
            options_subSeccion: [],
            options_serie: [],

            options_action_date: {
                format: "YYYY-MM-DD",
                useCurrent: false,
            },
            rows_proceedings: [],
            columns_proceedings: [
                {
                    label: "Sección",
                    name: "seccions",
                    sort: true,
                },
                {
                    label: "Subsección",
                    name: "subSections",
                },
                {
                    label: "Serie",
                    name: "serie",
                },
                {
                    label: "Subserie",
                    name: "subSerie",
                },

                {
                    label: "Nombre",
                    name: "name",
                },
                {
                    label: "Descripción",
                    name: "description",
                },
                {
                    label: "Estado",
                    name: "state",
                    sort: true,
                },
            ],
            config: {
                show_refresh_button: false,
                show_reset_button: false,
                card_mode: false,
                per_page: 5,
            },
            classes: {
                table: {
                    "table table-striped table-striped-bg-default mt-3": true,
                },
            },
        };
    },
    methods: {
        listSeccion: function () {
            axios
                .get("/getSeccions")
                .then((response) => {
                    this.filter = response.data;
                    console.log(this.filter);
                    let data = this.filter;
                    let aux = "";
                    let section = [];
                    for (let i in data) {
                        if (aux !== data[i].seccions_id) {
                            section.push({
                                id: data[i].seccions_id,
                                name: data[i].seccions,
                            });
                        }
                        aux = data[i].seccions_id;
                    }
                    this.options_seccions = section;
                })
                .catch((e) => {
                    console.log(e.response);
                });
        },

        listSubSeccion: function (seccion_id) {
            let data = this.filter;
            let subseccion = [];
            let aux = "";
            for (let i in data) {
                if (seccion_id == data[i].seccions_id) {
                    if (aux !== data[i].seccions_id) {
                        subseccion.push({
                            id: data[i].sub_seccion_id,
                            name: data[i].sub_seccion,
                        });
                    }
                    aux = data[i].sub_seccion_id;
                }
            }
            this.options_subSeccion = subseccion;
        },

        listSerie: function (sub_seccion_id) {
            let data = this.filter;
            let serie = [];
            let aux = "";
            for (let i in data) {
                if (sub_seccion_id == data[i].sub_seccion_id) {
                    if (aux !== data[i].sub_seccion_id) {
                        serie.push({
                            id: data[i].serie_id,
                            name: data[i].series,
                        });
                    }
                    aux = data[i].serie_id;
                }
            }
            this.options_serie = serie;
        },

        listSubserie: function (serie_id) {
            let data = this.filter;
            let subserie = [];
            let aux = "";
            for (let i in data) {
                if (serie_id == data[i].serie_id) {
                    console.log(aux);
                    if (aux !== data[i].serie_id) {
                        subserie.push({
                            id: data[i].sub_series_id,
                            name: data[i].sub_series,
                        });
                    }
                    aux = data[i].sub_series_id;
                }
            }
            this.options_subSerie = subserie;
        },

        listQuery: function () {
            axios
                .get("/getQuery")
                .then((response) => {
                    let data = response.data;
                    for (let i in data) {
                        this.rows_proceedings.push({
                            seccions: data[i].seccions,
                            subSections: data[i].subSections,
                            serie: data[i].serie,
                            subSerie: data[i].subSerie,
                            name: data[i].proceedings,
                            description: data[i].description,
                            state: data[i].state,
                        });
                    }
                })
                .catch((e) => {
                    console.log(e.response);
                });
        },
    },
};
</script>
<style scoped>
.navbar-medio {
    position: absolute;
    left: 0;
    top: 70px;
    height: 125px;
    width: 100%;
    /*z-index: 1;*/
    background-color: transparent;
    padding-left: 0 !important;
    padding-right: 0 !important;
    background-color: #ffffff;
    border: 1px solid #f4f5f6;
}
.container-uno {
    position: absolute;
    text-align: left;
    width: 15%;
    left: 5%;
    top: 5px;
}

.container-dos {
    position: absolute;
    left: 30%;
    width: 15%;
    top: 5px;
}
.container-tres {
    position: absolute;
    text-align: left;
    width: 15%;
    left: 55%;
    top: 5px;
}

.container-cuatro {
    position: absolute;
    text-align: left;
    width: 15%;
    left: 80%;
    top: 5px;
}

.container-cinco {
    position: relative;
    text-align: left;
    width: 15%;
    left: 83%;
    top: 5px;
}

.container-card {
    width: 50%;
}

.btn-form-submit {
    background-color: #8f141b;
    color: #dfd4a6;
    width: 45%;
}
.btn-form-cancel {
    background-color: #8f141b;
    color: #dfd4a6;
    border-color: #dfd4a6;
    border-radius: 20px;
    width: 45%;
}

.form-group-left {
    width: 60%;
    text-align: left;
}

.form-group-center {
    width: 60%;
    text-align: left;
}

.form-group-right {
    width: 60%;
    text-align: left;
}

.container-center {
    position: absolute;
    left: 40%;
    width: 33%;
}
.container-right {
    position: relative;
    text-align: right;
    width: 33%;
    left: 80%;
}

.container-left {
    position: absolute;
    text-align: left;
    width: 33%;
}

.container-button {
    position: relative;
    text-align: center;
    top: 50px;
}
.header-left {
    float: left;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #525f7f;
}
.header-right {
    float: right;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #525f7f;
}
.btn_table {
    background-color: #8f141b;
    color: #dfd4a6;
    border-color: #dfd4a6;
}

.btn_buscar {
    background-color: #8f141b;
    color: #dfd4a6;
    border-color: #dfd4a6;
    width: 50%;
}
.container-tabla {
    position: absolute;
    top: 150px;
    left: 10%;
    width: 80%;
}
</style>
