<template>
  <div>
  
    <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
      <!-- Card stats -->
      <div class="row"></div>
    </base-header>
    <div class="container-fluid mt--7">
      <div class="row" v-if="proceedings_filter == null">
        <div class="col">
          <div class="card shadow">
            <div class="card-header bg-transparent">
              <h3 class="mb-0">Inventario</h3>
            </div>
            <div class="card-body">
              <b-form>
                <div class="row">
                  <div class="col">
                    <div class="form-group">
                      <label>Sección:</label>
                      <multiselect
                        v-model="seccions"
                        placeholder="Seleccione el filtro"
                        :options="options_seccions"
                        label="show_data"
                        @input="listSubSeccion(seccions.id)"
                      >
                      </multiselect>
                    </div>

                    <div class="form-group">
                      <label>Subsección:</label>
                      <multiselect
                        v-model="subSeccion"
                        placeholder="Seleccione el filtro"
                        :options="options_subSeccion"
                        label="show_data"
                        @input="listSerie(subSeccion.id)"
                      >
                      </multiselect>
                    </div>
                  </div>
                  <div class="col">
                    <div class="form-group">
                      <label>Serie:</label>
                      <multiselect
                        v-model="serie"
                        placeholder="Seleccione el filtro"
                        :options="options_serie"
                        label="show_data"
                        @input="listSubserie(serie.id)"
                      >
                      </multiselect>
                    </div>
                    <div class="form-group">
                      <label>Subserie:</label>
                      <multiselect
                        v-model="subSerie"
                        placeholder="Seleccione el filtro"
                        :options="options_subSerie"
                        label="show_data"
                      >
                      </multiselect>
                    </div>
                  </div>
                </div>
              </b-form>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col">
          <div class="card" style="margin-top: 6rem">
            <div class="card-header" v-if="proceedings_filter == null">
              <div class="card-title">
                <h3>Inventario {{ support_filter }}</h3>
              </div>
            </div>
            <div
              v-if="
                seccions.name == null &&
                subSeccion.name == null &&
                serie.name == null &&
                subSerie.name == null &&
                proceedings_filter == null
              "
            >
              <vue-bootstrap4-table
                :rows="lists"
                :columns="columns_proceedings"
                :config="config"
                :classes="classes"
              >
                <template slot="numberProceedings" slot-scope="props">
                  <i>
                    <a
                      class="proceedings_data_select"
                      v-on:click="proceedings_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
                <template slot="documents_support" slot-scope="props">
                  <i>
                    <a
                      class="proceedings_data_select"
                      v-on:click="support_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
                <template slot="sub_proceedings" slot-scope="props">
                  <div v-if="props.cell_value == null">
                    <b-button-group>
                      <a
                        :href="'soportes/expediente/' + support_filter"
                        data-toggle="tooltip"
                        data-placement="top"
                        title="Descargar Soporte"
                      >
                        <i
                          :link="{
                            icon: 'ni ni-ruler-pencil text-orange',
                          }"
                          aria-hidden="true"
                        ></i>
                        <sidebar-item
                          :link="{
                            icon: 'ni ni-ruler-pencil text-orange',
                          }"
                        />
                      </a>
                    </b-button-group>
                  </div>
                  <div v-else>
                    <b-button-group>
                      <a
                        :href="
                          'soportes/expediente/subexpediente/' + support_filter"
                        data-toggle="tooltip"
                        data-placement="top"
                        title="Descargar Soporte"
                      >
                        <sidebar-item
                          :link="{
                            icon: 'ni ni-ruler-pencil text-orange',
                          }"
                        />
                      </a>
                    </b-button-group>
                  </div>
                </template>
              </vue-bootstrap4-table>
            </div>
            <div v-if="proceedings_filter != null">
              <div class="container-fluid mt--7">
                <div class="row">
                  <div class="col">
                    <div class="card shadow">
                      <div class="card-header" bg-transparent>
                        <h3 class="mb-0">Expediente</h3>
                      </div>
                      <div class="card-body">
                        <h3 class="mb-0">
                          Numero del expediente: {{ proceedings_filter }}
                        </h3>
                      </div>
                      <div class="card-body">
                        <b-button v-on:click="data_null()"
                          >Regresar a inventario</b-button
                        >
                      </div>

                      <vue-bootstrap4-table
                        :rows="SearchProceedings"
                        :columns="columns_proceedings"
                        :config="config"
                        :classes="classes"
                      >
                      </vue-bootstrap4-table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div
              v-if="
                seccions.name != null &&
                subSeccion.name == null &&
                serie.name == null &&
                subSerie.name == null &&
                proceedings_filter == null
              "
            >
              <vue-bootstrap4-table
                :rows="SearchSeccion"
                :columns="columns_proceedings"
                :config="config"
                :classes="classes"
              >
                <template slot="documents_support" slot-scope="props">
                  <i>
                    <a
                      class="support_data_select"
                      v-on:click="support_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
              </vue-bootstrap4-table>
            </div>

            <div
              v-if="
                seccions.name != null &&
                subSeccion.name != null &&
                serie.name == null &&
                subSerie.name == null &&
                proceedings_filter == null
              "
            >
              <vue-bootstrap4-table
                :rows="SearchSubSeccion"
                :columns="columns_proceedings"
                :config="config"
                :classes="classes"
              >
                <template slot="numberProceedings" slot-scope="props">
                  <i>
                    <a
                      class="proceedings_data_select"
                      v-on:click="proceedings_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
              </vue-bootstrap4-table>
            </div>

            <div
              v-if="
                seccions.name != null &&
                subSeccion.name != null &&
                serie.name != null &&
                subSerie.name == null &&
                proceedings_filter == null
              "
            >
              <vue-bootstrap4-table
                :rows="SearchSerie"
                :columns="columns_proceedings"
                :config="config"
                :classes="classes"
              >
                <template slot="numberProceedings" slot-scope="props">
                  <i>
                    <a
                      class="proceedings_data_select"
                      v-on:click="proceedings_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
              </vue-bootstrap4-table>
            </div>

            <div
              v-if="
                seccions.name != null &&
                subSeccion.name != null &&
                serie.name != null &&
                subSerie.name != null &&
                proceedings_filter == null
              "
            >
              <vue-bootstrap4-table
                :rows="SearchSubSerie"
                :columns="columns_proceedings"
                :config="config"
                :classes="classes"
              >
                <template slot="numberProceedings" slot-scope="props">
                  <i>
                    <a
                      class="proceedings_data_select"
                      v-on:click="proceedings_data_select(props.cell_value)"
                      >{{ props.cell_value }}</a
                    >
                  </i>
                </template>
              </vue-bootstrap4-table>
            </div>
          </div>
        </div>
      </div>
    </div>
    <br>
    <br>
    <br>
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
    this.listDataAll();
    this.getData();
  },
  name: "Inventario",
  components: { Multiselect, swal, VueBootstrap4Table },
  data() {
    return {
      proceedings_filter: null,
      support_filter: null,
      expediente: "",
      lists: [],
      buscar: "",
      subSerie: "",
      comment: "",
      nameProceedings: "",
      openDate: "",
      fileNumber: "",
      seccions: "",
      subSeccion: "",
      serie: "",
      dataAll: "",
      proceedings_modal: false,

      filter: [],
      options_subSerie: [],
      options_seccions: [],
      options_subSeccion: [],
      option_label_Seccion: [],
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
          label: "# Expediente",
          name: "numberProceedings",
        },
        {
          label: "Expediente",
          name: "proceedings",
        },
        {
          label: "Fecha expediente",
          name: "proceedings_data",
        },
        {
          label: "Descripcion expediente",
          name: "description",
          sort: true,
        },
        {
          label: "SubExpedie",
          name: "sub_proceedings",
          sort: true,
        },
        {
          label: "LOG",
          name: "documents_support",
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
    proceedings_data_select: function (message) {
      this.proceedings_filter = message;
    },
    support_data_select: function (message) {
      this.support_filter = message;
    },

    data_null: function (message) {
      this.proceedings_filter = null;
    },

    getData: function () {
      axios.get("/getDataAll").then((response) => {
        this.lists = response.data;
      });
    },

    messageAlert: function (state, title, msj) {
      this.$swal({
        type: state,
        title: title,
        text: msj,
      });
    },

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
                show_data: [data[i].seccions_code, data[i].seccions],
              });
            }
            aux = data[i].seccions_id;
          }
          this.options_seccions = section;
        })
        .catch((e) => {
          console.log(sectionCode);
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
              show_data: [data[i].subsection_code, data[i].sub_seccion],
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
              show_data: [data[i].serie_code, data[i].series],
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
              show_data: [data[i].subserie_code, data[i].sub_series],
            });
          }
          aux = data[i].sub_series_id;
        }
      }
      this.options_subSerie = subserie;
    },
    listDataAll: function () {
      axios
        .get("/getDataAll")
        .then((response) => {
          let data = response.data;
          for (let i in data) {
            this.rows_proceedings.push({
              seccions: data[i].seccions,
              subSections: data[i].subSections,
              serie: data[i].serie,
              subSerie: data[i].subSerie,
              numberProceedings: data[i].numberProceedings,
              proceedings: data[i].proceedings,
              proceedings_data: data[i].proceedings_data,
              description: data[i].description,
              log: data[i].documents_support,
            });
          }
        })
        .catch((e) => {
          console.log(e.response);
        });
    },
  },
  computed: {
    SearchSeccion: function () {
      return this.lists.filter((item) =>
        item.seccions.includes(this.seccions.name)
      );
    },
    SearchSubSeccion: function () {
      return this.SearchSeccion.filter((item) =>
        item.subSections.includes(this.subSeccion.name)
      );
    },
    SearchSerie: function () {
      return this.SearchSubSeccion.filter((item) =>
        item.serie.includes(this.serie.name)
      );
    },
    SearchSubSerie: function () {
      return this.SearchSerie.filter((item) =>
        item.subSerie.includes(this.subSerie.name)
      );
    },
    SearchProceedings: function () {
      return this.lists.filter((item) =>
        item.numberProceedings.includes(this.proceedings_filter)
      );
    },
  },
};
</script>
<style scoped>
.proceedings_data_select {
  color: #248af8;
}

.bg-gradient-success {
  background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
}

.container-card {
  width: 50%;
}

.btn-form-submit {
  background-color: #8f141b;
  color: #dfd4a6;
  border-radius: 20px;
  width: 30%;
}

.btn-form-cancel {
  background-color: #dfd4a6;
  color: #8f141b;
  border-radius: 20px;
  width: 30%;
}

.form-group-left {
  width: 60%;
  text-align: left;
}

.form-group-right {
  width: 100%;
  text-align: left;
}

.container-right {
  float: right;
  width: 50%;
}

.container-left {
  float: left;
  width: 50%;
}

.container-button {
  position: relative;
  top: 20px;
  text-align: center;
}

.text-bcard {
  text-align: left;
}
.contenedor-tablas {
  width: 100%;
}
</style>