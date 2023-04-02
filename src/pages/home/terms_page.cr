class Home::TermsPage < MainLayout
  def page_title
    "Terms of Use"
  end

  def content
    div class: "flex flex-col h-full justify-between" do
      mount Shared::Navbar
      div class: "w-full flex-grow text-gray-800 bg-gray-200 dark:bg-gray-700 dark:text-gray-200" do
        mount Shared::MarkdownContent do
          raw Luce.to_html <<-MARKDOWN
          # Terms of Use

          1. Acceptance of Terms

            By accessing and using Paste69 ("the Service"), including the API, you ("the User") agree to be bound by these Terms of Use ("the Terms"). These Terms govern your access to and use of the Service and any information, text, graphics, or other materials uploaded, downloaded, or appearing on the Service (collectively referred to as "Content").

            Watzon Development ("the Company") reserves the right to update or modify these Terms at any time without prior notice. Your continued use of the Service after any such changes constitutes your acceptance of the new Terms. If you do not agree to any of these Terms, please do not use the Service.

          2. Registration

            While certain features of the Service may be accessed without registering, registration may be required for access to additional features, including the API. When registering, you agree to provide accurate and complete information and keep this information up-to-date.

          3. Use of the Service

            The User agrees not to use the Service for any unlawful purposes or in any way that violates these Terms. The User is responsible for any Content posted, submitted, or transmitted through the Service.

            Prohibited activities include, but are not limited to:

            a. Uploading, posting, or transmitting any Content that infringes upon any copyright, trademark, or other intellectual property rights of any party.
            b. Using the Service to transmit any unsolicited or unauthorized advertising, promotional materials, or spam.
            c. Engaging in any activities that disrupt, interfere with, or damage the Service or its servers and networks.
            d. Attempting to gain unauthorized access to the Service, accounts, or systems through hacking, password mining, or other means.

          4. API Usage

            By accessing and using the API, the User agrees to the following terms:

            a. The Company grants the User a limited, non-exclusive, non-transferable, revocable license to use the API for personal or commercial purposes, subject to these Terms.
            b. The User shall not use the API for any illegal or unauthorized purposes or in any manner that violates these Terms.
            c. The User shall not use the API in a way that exceeds any rate limitations or usage restrictions set by the Company.

          5. Content Ownership

            The User retains ownership of any Content submitted, posted, or displayed through the Service. By submitting, posting, or displaying Content, the User grants the Company a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, distribute, and display such Content on the Service.

          6. Termination

            The Company reserves the right to suspend or terminate the User's access to the Service and the API, without notice, for any reason, including but not limited to violations of these Terms.

          7. Disclaimer of Warranties and Limitation of Liability

            The Service and API are provided on an "as is" and "as available" basis. The Company disclaims all warranties, express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, and non-infringement.

            In no event shall the Company be liable for any direct, indirect, incidental, special, consequential, or exemplary damages arising out of or in connection with the User's access to or use of the Service and API.

          8. Governing Law

            These Terms shall be governed by and construed in accordance with the laws of the United States of America, without regard to its conflict of law provisions.

          9. Contact Information

            For any questions or concerns regarding these Terms, please contact us at support (at) paste69.com.
          MARKDOWN
        end
      end
      mount Shared::Footer
    end
  end
end
