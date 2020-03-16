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
import AppItemList from "./AppItemList";
import axios from "axios/dist/axios";

export default {
	name: "DomainList",
	data: function(){
		return {
			items: {
				prefix: [],
				sufix:[],
			},
			domains: [],
		};
	},
	components: {
		AppItemList
	},
	methods: {
		addItem: function(item){
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						mutation ($item: ItemInput) {
							newItem: saveItem(item: $item) {
								id,
								type,
								description
							}
						}
					`,
					variables: {
						item
					}
				}
			}).then(response => {
				this.items[item.type].push(response.data.data.newItem);
				this.generateDomains();
			});
		},
		deleteItem: function(item){
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						mutation ($id: Int) {
							deleted: deleteItem(id: $id)
						}
					`,
					variables: {
						id: item.id
					}
				}
			}).then(response => {
				const query = response.data;
				if(query.data.deleted){
					this.items[item.type].splice(this.items[item.type].indexOf(item), 1);
					this.generateDomains();
				}
			});
		},
		getItems(type){
			return axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						query ($type: String){
							items: items (type: $type) {
								id
								type
								description
							}
						}
					`,
					variables: {
						type
					}
				}
			}).then(response => {
				const query = response.data;
				this.items[type] = query.data.items;
			});
		},
		generateDomains(){
			axios({
				url: "http://localhost:4000",
				method: "post",
				data: {
					query: `
						mutation {
							domains: generateDomains {
								name
								checkout
								available
							}
						}
					`
				}
			}).then(response => {
				const query = response.data;
				this.domains = query.data.domains;
			});
		},
		openDomain(domain) {
			this.$router.push({
				path: `/domains/${domain.name}`,
			});
		}
	},
	created(){
		Promise.all([
			this.getItems("prefix"),
			this.getItems("sufix")
		]).then(() => {
			this.generateDomains();
		});
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