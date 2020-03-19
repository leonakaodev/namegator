<template>
    <div id="main">
    <div class="container">
            <div class="row">
                <div class="col-md">
                    <AppItemList title="Prefixos" type="prefix" :items="items.prefix" @addItem="addItem" @deleteItem="deleteItem"></AppItemList>
                </div>
                <div class="col-md">
                    <AppItemList title="Sufixos" type="sufix" :items="items.sufix" @addItem="addItem" @deleteItem="deleteItem"></AppItemList>
                </div>
            </div>
            <br>
            <h5> Domínios <span class="badge badge-info">{{domains.length || 0}}</span></h5>
            <div class="card">
                <div class="card-body">
                    <ul class="list-group">
                        <li v-for="domain in domains" :key="domain.nome" class="list-group-item">
                            <div class="row">
                                <div class="col-md-6">
                                    {{ domain.name }}
                                </div>
								<div class="col-md-3">
									<span class="badge badge-info">{{ domain.available ? "Disponível" : "Indisponível" }}</span>
								</div>
                                <div class="col-md-3 text-right">
                                    <a class="btn btn-info" :href="domain.checkout" target="blank">
                                        <span class="fa fa-shopping-cart"></span>
                                    </a>
                                    &nbsp;
                                    <button class="btn btn-info" @click="openDomain(domain)">
                                        <span class="fa fa-search"></span>
                                    </button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { mapState, mapActions} from "vuex";
import AppItemList from "./AppItemList";

export default {
	name: "DomainList",
	data: function(){
		return {};
	},
	components: {
		AppItemList
	},
	methods: {
		...mapActions(["addItem", "deleteItem", "getItems", "generateDomains"]),
		openDomain(domain) {
			this.$router.push({
				path: `/domains/${domain.name}`,
			});
		}
	},
	computed: {
		...mapState(["items", "domains"])
	}
};
</script>

<style>
#main {
	background-color: #E7E7E7;
    padding-top: 30px;
    padding-bottom: 30px;
}
</style>