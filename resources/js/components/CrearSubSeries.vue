<template>
  <div>
    <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
      <!-- Card stats -->
      <div class="row"></div>
    </base-header>
    <div class="container-fluid mt--7">
      <div class="card">
        <div class="card-header">
          <div class="card-title"><h3>Crear SubSeries</h3></div>
        </div>
        <div class="card-body">
          <b-form>
            <div class="row">
              <div class="col">
                <div class="form-group">
                  <label>Seccion:</label>
                  <multiselect
                    v-model="seccions"
                    placeholder="Seleccione el filtro"
                    :options="options_seccions"
                    label="name"
                  >
                  </multiselect>
                </div>

                <div class="form-group">
                  <label>Subseccion</label>
                  <multiselect
                    v-model="subSection"
                    placeholder="Seleccione el filtro"
                    :options="SearchSubseccion"
                    label="subseccion_name"
                  >
                  </multiselect>
                </div>
                <div class="form-group">
                  <label>Serie</label>
                  <multiselect
                    v-model="serieId"
                    placeholder="Seleccione el filtro"
                    :options="SearchSerie"
                    label="serie"
                  >
                  </multiselect>
                </div>
              </div>
              <div class="col">
                <div class="form-group">
                  <label>Nombre de la SubSerie</label>
                  <input
                    type="text"
                    v-model="nameSubSerie"
                    class="form-control"
                  />
                </div>
                <div class="form-group">
                  <label>Numero de la SubSerie</label>
                  <input
                    type="text"
                    v-model="subSerieCode"
                    class="form-control"
                  />
                </div>
                <div class="container-button">
                  <b-button class="btn-form-cancel">Cancelar</b-button>
                  <b-button class="btn-form-submit" @click="setSubSerie"
                    >Crear
                  </b-button>
                </div>
              </div>
            </div>
          </b-form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Multiselect from "vue-multiselect";
import axios from "axios";
import swal from "sweetalert";
export default {
  mounted() {
    this.listSeccion();
    this.getData();
    this.getData_Serie();
  },
  name: "CrearSubSeries",
  components: { Multiselect, swal },

  data() {
    return {
      seccions: "",
      subSection: "",
      serieId: "",
      nameSubSerie: "",
      subSerieCode: "",
      options_seccions: [],
      lists: [],
      lists_serie: [],
    };
  },

  methods: {
    messageAlert: function (state, title, msj) {
      this.$swal({
        type: state,
        title: title,
        text: msj,
      });
    },
    getData: function () {
      axios.get("/getSeccionAll").then((response) => {
        this.lists = response.data;
      });
    },
    getData_Serie: function () {
      axios.get("/get_serie_all").then((response) => {
        this.lists_serie = response.data;
      });
    },
    listSeccion: function () {
      axios
        .get("/get_seccion_multi")
        .then((response) => {
          let data = response.data;
          for (let i in data) {
            this.options_seccions.push({
              id: data[i].id,
              name: data[i].name,
              sectionCode: data[i].sectionCode,
            });
          }
        })
        .catch((e) => {
          console.log(e.response);
        });
    },

    setSubSerie: function () {
      let formData = {
        serieId: this.serieId.serie_id,
        subSerieCode: this.subSerieCode,
        nameSubSerie: this.nameSubSerie,
      };
      axios
        .post("/setSubSerie", formData)
        .then((response) => {
          let data = response.data;
          if (data == true) {
            this.messageAlert(
              "success",
              "Buen trabajo",
              "Se ha creado exitosamente la subserie."
            );
          }
        })
        .catch((e) => {
          console.log(e.response);
        });
    },
  },
  computed: {
    SearchSubseccion: function () {
      return this.lists.filter((item) =>
        item.seccions.includes(this.seccions.name)
      );
    },
    SearchSerie: function () {
      return this.lists_serie.filter((item) =>
        item.subSections.includes(this.subSection.subseccion_name)
      );
    },
  },
};
</script>
<style scoped>
.navbar-medio {
  position: absolute;
  left: 0;
  top: 70px;
  height: 70px;
  width: 100%;
  /*z-index: 1;*/
  background-color: transparent;
  padding-left: 0 !important;
  padding-right: 0 !important;
  background-color: #ffffff;
  border: 1px solid #f4f5f6;
}
.text-titulo {
  position: relative;
  text-align: center;
  color: #8f141b;
  font-weight: bolder;
  font-size: x-large;
  top: 11px;
}
.bg-gradient-success {
  background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
}
</style>