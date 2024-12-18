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
        img.withRun("--name run-${env.BUILD_ID} -p 9090:80") { c ->
            // Attendre que le conteneur démarre et tester avec curl
            sh 'sleep 5 && curl http://localhost:8080'
        }
    }

    // Stage Push : Pousser l'image vers le registre GitLab
    stage('Push') {
        docker.withRegistry('https://registry.gitlab.com', 'reg1') {
            img.push('latest') // Tag 'latest'
            img.push() // Tag basé sur BUILD_ID
        }
    }
}
