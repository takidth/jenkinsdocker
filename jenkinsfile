def pipelineContext = [:]
node {

    // Définir le registre et l'image
    def registryProjet = 'registry.gitlab.com/vde-formation/jenkinsformation'
    def IMAGE = "${registryProjet}:version-${env.BUILD_ID}"

    echo "IMAGE = $IMAGE"

    // Stage Clone : Clonage depuis la branche 'main'
    stage('Clone') {
        checkout([
            $class: 'GitSCM',
            branches: [[name: 'main']],
            userRemoteConfigs: [[url: 'https://github.com/takidth/jenkinsdocker.git']]
        ])
    }

    // Stage Build : Construction de l'image Docker
    def img = stage('Build') {
        docker.build("$IMAGE", '.')
    }

    // Stage Run : Test de l'image en lançant un conteneur temporaire
    stage('Run') {
        img.withRun("--name run-${env.BUILD_ID} -p
