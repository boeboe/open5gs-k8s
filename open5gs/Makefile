# Makefile

OPEN5GS_IMAGE = boeboe/open5gs
OPEN5GS_UI_IMAGE = boeboe/open5gs-ui

OPEN5GS_DOCKER_DIR = images/open5gs
OPEN5GS_UI_DOCKER_DIR = images/open5gs-webui

TAG = v2.2.0

# Kubernetes deployment folders
K8S_DEPLOY_DIR								?= ./manifests
HSS_K8S_DEPLOY_DIR   					?= ${K8S_DEPLOY_DIR}/open5gs-hss
MME_K8S_DEPLOY_DIR      			?= ${K8S_DEPLOY_DIR}/open5gs-mme
MONGO_DB_K8S_DEPLOY_DIR 			?= ${K8S_DEPLOY_DIR}/open5gs-mongo-db
MONGO_EXPRESS_K8S_DEPLOY_DIR	?= ${K8S_DEPLOY_DIR}/dbg-mongo-express
NRF_K8S_DEPLOY_DIR      			?= ${K8S_DEPLOY_DIR}/open5gs-nrf
PCRF_K8S_DEPLOY_DIR     			?= ${K8S_DEPLOY_DIR}/open5gs-pcrf
SGW_C_K8S_DEPLOY_DIR    			?= ${K8S_DEPLOY_DIR}/open5gs-sgwc
SGW_U_K8S_DEPLOY_DIR    			?= ${K8S_DEPLOY_DIR}/open5gs-sgwu
SMF_K8S_DEPLOY_DIR      			?= ${K8S_DEPLOY_DIR}/open5gs-smf
UPF_K8S_DEPLOY_DIR      			?= ${K8S_DEPLOY_DIR}/open5gs-upf
WEB_UI_K8S_DEPLOY_DIR   			?= ${K8S_DEPLOY_DIR}/open5gs-webui

.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build-all: build-core build-ui  ## Build all images
build-all-clean: build-core-clean build-ui-clean  ## Build all images without cache
push-all: push-core push-ui  ## Push all images
remove-all: remove-core remove-ui  ## Remove all images locally

### Core Image ###
build-core: 
	docker build --pull -t ${OPEN5GS_IMAGE}:${TAG} --build-arg VERSION=${TAG} ${OPEN5GS_DOCKER_DIR}
	docker tag ${OPEN5GS_IMAGE}:${TAG} ${OPEN5GS_IMAGE}:${TAG}

build-core-clean:
	docker build --pull --no-cache -t ${OPEN5GS_IMAGE}:${TAG} --build-arg VERSION=${TAG} ${OPEN5GS_DOCKER_DIR}
	docker tag ${OPEN5GS_IMAGE}:${TAG} ${OPEN5GS_IMAGE}:${TAG}

push-core:
	docker push ${OPEN5GS_IMAGE}:${TAG}

remove-core:
	docker rmi ${OPEN5GS_IMAGE}:${TAG}

### UI Image ###
build-ui:
	docker build --pull -t ${OPEN5GS_UI_IMAGE}:${TAG} --build-arg VERSION=${TAG} ${OPEN5GS_UI_DOCKER_DIR}
	docker tag ${OPEN5GS_UI_IMAGE}:${TAG} ${OPEN5GS_UI_IMAGE}:${TAG}

build-ui-clean:
	docker build --pull --no-cache -t ${OPEN5GS_UI_IMAGE}:${TAG} --build-arg VERSION=${TAG} ${OPEN5GS_UI_DOCKER_DIR}
	docker tag ${OPEN5GS_UI_IMAGE}:${TAG} ${OPEN5GS_UI_IMAGE}:${TAG}

push-ui:
	docker push ${OPEN5GS_UI_IMAGE}:${TAG} || true

remove-ui:
	docker rmi ${OPEN5GS_UI_IMAGE}:${TAG} || true

deploy:  ## Deploy Open5GS Components
	kubectl apply -f ${K8S_DEPLOY_DIR}/00_namespace.yaml || true
	kubectl apply -k ${HSS_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${MME_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${MONGO_DB_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${MONGO_EXPRESS_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${NRF_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${PCRF_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${SGW_C_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${SGW_U_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${SMF_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${UPF_K8S_DEPLOY_DIR} || true
	kubectl apply -k ${WEB_UI_K8S_DEPLOY_DIR} || true


undeploy: ## Undeploy Open5GS Components
	kubectl delete -k ${WEB_UI_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${UPF_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${SMF_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${SGW_U_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${SGW_C_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${PCRF_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${NRF_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${MONGO_EXPRESS_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${MONGO_DB_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${MME_K8S_DEPLOY_DIR} || true
	kubectl delete -k ${HSS_K8S_DEPLOY_DIR} || true
	kubectl delete -f ${K8S_DEPLOY_DIR}/00_namespace.yaml || true

redeploy: undeploy deploy ## Redeploy Open5GS Components