<template>
  <div>
    <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
      <!-- Card stats -->
      <div class="row"></div>
    </base-header>
    <div class="container-fluid mt--7">
      <div class="card">
        <div class="card-header">
          <div class="card-title"><h3>Crear Serie</h3></div>
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
              </div>
              <div class="col">
                <div class="form-group">
                  <label>Nombre de la Serie</label>
                  <input type="text" v-model="nameSerie" class="form-control" />
                </div>
                <div class="form-group">
                  <label>Numero de la Serie:</label>
                  <input type="text" v-model="serieCode" class="form-control" />
                </div>

                <div class="container-button">
                  <b-button class="btn-form-cancel">Cancelar</b-button>
                  <b-button class="btn-form-submit" @click="setSerie"
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
  },
  name: "CrearSeries",
  components: { Multiselect, swal },

  data() {
    return {
      sectionId: "",
      nameSerie: "",
      subSection: "",
      serieCode: "",
      seccions: "",
      options_seccions: [],
      lists: [],
      subSectionId: "",
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
    setSerie: function () {
      let formData = {
        subSectionId: this.subSection.subseccion_id,
        serieCode: this.serieCode,
        nameSerie: this.nameSerie,
      };
      axios
        .post("/setSerie", formData)
        .then((response) => {
          let data = response.data;
          if (data == true) {
            this.messageAlert(
              "success",
              "Buen trabajo",
              "Se ha creado exitosamente la serie."
            );
          }
        })
        .catch((e) => {
          console.log(e.response);
        });
    },
    listSubSeccion: function () {
      axios
        .get("/get_subseccion_multi")
        .then((response) => {
          let data = response.data;
          for (let i in data) {
            this.options_subSeccion.push({
              id: data[i].id,
              name: data[i].name,
              subSectionCode: data[i].subSectionCode,
              sectionId: data[i].subSectionCode,
            });
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