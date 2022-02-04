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
            <div class="card-header" bg-transparent>
              <h3 class="mb-0">Menú Documentos</h3>
              
  
            </div>
          
            <vue-bootstrap4-table
              :rows="SearchProceedings"
              :columns="columns_proceedings"
              :config="config"
              :classes="classes"
            >
          <template slot="documents_support" slot-scope="props">
            <img v-on:click="pdf_select(props.cell_value)" class="pdf_icono" src="../assets/img/pdf.png" />
                </template>
            </vue-bootstrap4-table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import pdf from 'vue-pdf';
import Multiselect from "vue-multiselect";
import VueBootstrap4Table from "vue-bootstrap4-table";
import swal from "sweetalert";
import axios from "axios";
export default {
  mounted() {
    this.listDataAll();
    this.getData();
  },
  name: "Inventario",
  components: { Multiselect, swal, VueBootstrap4Table},
  data() {
    return {
      pdf_data_select:"",
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
      options_serie: [],

      options_action_date: {
        format: "YYYY-MM-DD",
        useCurrent: false,
      },
      rows_proceedings: [],
      columns_proceedings: [
        {
          label: "# Expediente",
          name: "numberProceedings",
        },
        {
          label: "Expediente",
          name: "proceedings",
        },

        {
          label: "Documento",
          name: "documents",
          sort: true,
        },
        {
          label: "Descripcion documento",
          name: "descriptiondocuments",
          sort: true,
        },
        {
          label: "Fecha de documento",
          name: "documents_data",
          sort: true,
        },
        {
          label: "Estado",
          name: "state",
          sort: true,
        },
        {
          
          name: "documents_support",
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
    pdf_select: function (message) {
      this.pdf_data_select = message;
    },
    getData: function () {
      axios.get("/getDataAll").then((response) => {
        this.lists = response.data;
      });
    },

    listDataAll: function () {
      axios
        .get("/getDataAll")
        .then((response) => {
          let data = response.data;
          for (let i in data) {
            this.rows_proceedings.push({
              numberProceedings: data[i].numberProceedings,
              proceedings: data[i].proceedings,
              documents: data[i].documents,
              descriptiondocuments: data[i].descriptiondocuments,
              documents_data: data[i].documents_data,
              state: state,
              documents_support:data[i].documents_support,
            });
          }
        })
        .catch((e) => {
          console.log(e.response);
        });
    },
  },
  computed: {
    SearchProceedings: function () {
      return this.lists.filter((item) =>
        item.numberProceedings.includes(this.buscar)
      );
    },
  },
};
</script>
<style scoped>
.bg-gradient-success {
  background: linear-gradient(87deg, #8f141b 0, #8f141b 100%) !important;
}
.pdf_icono{
  width: 32px;
  height: 32px;
    
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
  width: 70%;
}
</style>
