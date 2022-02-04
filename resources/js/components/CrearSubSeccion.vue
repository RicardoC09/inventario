<template>
  <div>
    <base-header type="gradient-success" class="pb-6 pb-8 pt-5 pt-md-8">
      <!-- Card stats -->
      <div class="row"></div>
    </base-header>
    <div class="container-fluid mt--7">
      <div class="card">
        <div class="card-header">
          <div class="card-title"><h3>Crear SubSeccion</h3></div>
        </div>
        <div class="card-body">
          <b-form>
            <div class="row">
              <div class="col">
                <div class="form-group">
                  <label>id de la seccion:</label>
                  <multiselect
                    v-model="seccions"
                    placeholder="Seleccione el filtro"
                    :options="options_seccions"
                    label="name"
                  >
                  </multiselect>
                </div>
              </div>
              <div class="col">
                <div class="form-group">
                  <label>Nombre de la SubSeccion</label>
                  <input
                    type="text"
                    v-model="nameSubSeccion"
                    class="form-control"
                  />
                </div>
                <div class="form-group">
                  <label>Numero de la SubSeccion:</label>
                  <input
                    type="text"
                    v-model="subSectionCode"
                    class="form-control"
                  />
                </div>
                <div class="container-button">
                  <b-button class="btn-form-cancel">Cancelar</b-button>
                  <b-button class="btn-form-submit" @click="setSubSeccion"
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
  },
  name: "CrearSubSeccion",
  components: { Multiselect, swal },

  data() {
    return {
      nameSubSeccion: "",
      subSectionCode: "",
      seccions: "",
      options_seccions: [],
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
    setSubSeccion: function () {
      let formData = {
        sectionId: this.seccions.id,
        subSectionCode: this.subSectionCode,
        nameSubSeccion: this.nameSubSeccion,
      };
      axios
        .post("/setSubSeccion", formData)
        .then((response) => {
          let data = response.data;
          if (data == true) {
            this.messageAlert(
              "success",
              "Buen trabajo",
              "Se ha creado exitosamente SubSeccion."
            );
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