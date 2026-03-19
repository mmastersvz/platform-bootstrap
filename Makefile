CLUSTER_NAME=platform
ARGOCD_NS      := argocd
ARGOCD_PORT    := 8888

up:
	@echo "Bootstrapping platform..."
	./scripts/create-cluster.sh
	./scripts/install-argocd.sh
	./scripts/bootstrap-argocd-apps.sh https://github.com/mmastersvz/platform-gitops.git

down:
	k3d cluster delete $(CLUSTER_NAME)

argocd-password:
	kubectl -n argocd get secret argocd-initial-admin-secret \
	-o jsonpath="{.data.password}" | base64 -d && echo

argocd-pf:
	kubectl port-forward svc/argocd-server -n $(ARGOCD_NS) $(ARGOCD_PORT):80

cluster-start:
	k3d cluster start $(CLUSTER_NAME)

cluster-stop:
	k3d cluster stop $(CLUSTER_NAME)
